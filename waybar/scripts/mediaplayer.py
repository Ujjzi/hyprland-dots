#!/usr/bin/env python3
# ╔═══════════════════════════════════════════════════════════╗
# ║  mediaplayer.py — MPRIS media info for Waybar            ║
# ║  Shows current track from any MPRIS-compatible player    ║
# ╚═══════════════════════════════════════════════════════════╝
import sys
import signal
import gi
gi.require_version('Playerctl', '2.0')
from gi.repository import Playerctl, GLib
import json

manager = Playerctl.PlayerManager()

def on_metadata(player, metadata, manager):
    if player.props.status == 'Playing' or player.props.status == 'Paused':
        track = player.get_title()
        artist = player.get_artist()
        status = player.props.status

        # Truncate long track names
        if track and len(track) > 22:
            track = track[:22] + "…"
        if artist and len(artist) > 18:
            artist = artist[:18] + "…"

        # Detect Spotify specifically
        player_name = player.props.player_name.lower()
        icon_key = "spotify" if "spotify" in player_name else "default"

        label = ""
        if artist and track:
            label = f"{artist} — {track}"
        elif track:
            label = track

        # Pause indicator
        if status == "Paused":
            label = f"⏸ {label}"

        tooltip = f"{player.props.player_name}\n{artist} — {track}" if artist else track

        output = {
            "text": label,
            "tooltip": tooltip,
            "class": icon_key,
            "alt": icon_key
        }
    else:
        output = {"text": "", "tooltip": "", "class": "stopped", "alt": "default"}

    sys.stdout.write(json.dumps(output) + "\n")
    sys.stdout.flush()

def on_play(player, status, manager):
    on_metadata(player, player.props.metadata, manager)

def on_exit(player, manager):
    output = {"text": "", "tooltip": "", "class": "stopped"}
    sys.stdout.write(json.dumps(output) + "\n")
    sys.stdout.flush()

def init_player(name):
    player = Playerctl.Player.new_from_name(name)
    player.connect('playback-status', on_play, manager)
    player.connect('metadata', on_metadata, manager)
    player.connect('exit', on_exit, manager)
    manager.manage_player(player)
    on_metadata(player, player.props.metadata, manager)

def on_name_appeared(manager, name):
    init_player(name)

def on_name_vanished(manager, name):
    output = {"text": "", "tooltip": "", "class": "stopped"}
    sys.stdout.write(json.dumps(output) + "\n")
    sys.stdout.flush()

manager.connect('name-appeared', on_name_appeared)
manager.connect('name-vanished', on_name_vanished)

for name in manager.props.player_names:
    init_player(name)

if not manager.props.player_names:
    output = {"text": "", "tooltip": "", "class": "stopped"}
    sys.stdout.write(json.dumps(output) + "\n")
    sys.stdout.flush()

main = GLib.MainLoop()
signal.signal(signal.SIGINT, lambda *args: main.quit())
main.run()
