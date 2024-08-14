from libqtile import bar, layout, widget
from libqtile.config import Click, Drag, Key, Match, Screen, ScratchPad, DropDown
from libqtile.lazy import lazy


mod = "mod4"
terminal = "kitty"


keys = [
    # Switch between windows.
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    # Move windows within workspace.
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    # Grow/Shrink windows.
    Key([mod, "shift"], "h", lazy.layout.shrink(), desc="Grow window to the right"),
    Key([mod, "shift"], "l", lazy.layout.grow(), desc="Grow window to the left"),
    # Window Management.
    Key([mod], "f", lazy.window.toggle_floating(), desc="Toggle floating"),
    Key([mod], "Tab", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod, "shift"], "Tab", lazy.next_layout(), desc="Next layout"),
    Key([mod, "shift"], "b", lazy.hide_show_bar("top"), desc="Toggle menubar"),
    Key([mod], "w", lazy.spawn("Qminimize -m"), desc="Minimize focused window"),
    Key([mod, "shift"], "w", lazy.spawn("Qminimize -u"), desc="List minimized windows"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    # Programs/Scripts.
    Key([mod], "r", lazy.spawn("ruler"), desc="Ruler"),
    Key([mod], "p", lazy.spawn("sh .config/wm/scripts/pass_menu.sh"), desc="Password manager"),
    Key([mod], "Return", lazy.spawn(f"{terminal} -e tmux"), desc="Terminal"),
    Key([mod], "b", lazy.spawn("qutebrowser"), desc="Browser"),
    # Auxiliary usages.
    Key([mod], "c", lazy.spawn("sh .config/wm/scripts/toggle_battery_mode.sh"), desc="Toggle battery usage mode"),
    Key([mod, "shift"], "t", lazy.spawn("sh .config/wm/scripts/toggle_mousepad.sh"), desc="Toggle trackpad"),
    Key([mod, "control"], "delete", lazy.spawn("betterlockscreen --lock"), desc="Lock screen"),
    Key([mod], "space", lazy.spawn("rofi -show run"), desc="Application launcher"),
    Key([mod], "s", lazy.spawn("flameshot gui"), desc="Screenshot"),
    Key([mod, "shift"], "s", lazy.spawn("flameshot screen"), desc="Screenshot entire screen"),
    Key([mod], "i", lazy.spawn("sh .config/wm/scripts/invert_colors.sh"), desc="Invert colors of focused window"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("sh .config/wm/scripts/inc_brightness.sh"), desc="Increase screen brightness"),
    Key([], "XF86MonBrightnessDown", lazy.spawn("sh .config/wm/scripts/dec_brightness.sh"), desc="Decrease screen brightness"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("sh .config/wm/scripts/inc_volume.sh"), desc="Increase audio volume"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("sh .config/wm/scripts/dec_volume.sh"), desc="Decrease audio volume"),
    Key([], "XF86AudioMute", lazy.spawn("sh .config/wm/scripts/mute_volume.sh"), desc="Mute audio"),
    # Scratchpads
    Key([mod], 'm', lazy.group['scratchpads'].dropdown_toggle('mails'), desc="Mails"),
    Key([mod], 'a', lazy.group['scratchpads'].dropdown_toggle('music'), desc="Music player"),
    Key([mod], 'u', lazy.group['scratchpads'].dropdown_toggle('math'), desc="Math utility"),
    Key([mod, "shift"], 'a', lazy.spawn("sh .config/wm/scripts/download_music.sh"), desc="Audio download utility"),
    Key([mod], 'o', lazy.group['scratchpads'].dropdown_toggle('obsidian'), desc="Obsidian"),
    Key([mod], 'y', lazy.group['scratchpads'].dropdown_toggle('files'), desc="File manager"),
]


groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )

groups.extend([
    ScratchPad('scratchpads', [
        DropDown(
            'music',
            f'{terminal} -e ncmpcpp',
            height = 0.8,
            width = 0.8,
            x = 0.1,
            y = 0.1,
            on_focus_lost_hide = True,
            warp_pointer = False,
        ),
        DropDown(
            'mails',
            f'{terminal} -e neomutt',
            height = 0.8,
            width = 0.8,
            x = 0.1,
            y = 0.1,
            on_focus_lost_hide = True,
            warp_pointer = True,
        ),
        DropDown(
            'math',
            f'{terminal} -e kalc',
            height = 0.8,
            width = 0.4,
            x = 0.5,
            y = 0.1,
            on_focus_lost_hide = True,
            warp_pointer = True,
        ),
        DropDown(
            'obsidian',
            f'{terminal} -e nvim +ObsidianSearch',
            height = 0.8,
            width = 0.4,
            x = 0.5,
            y = 0.1,
            on_focus_lost_hide = True,
            warp_pointer = True,
        ),
        DropDown(
            'files',
            f'{terminal} -e yazi',
            height = 0.8,
            width = 0.4,
            x = 0.5,
            y = 0.1,
            on_focus_lost_hide = True,
            warp_pointer = True,
        ),
    ]),
])

layout_default_args = {
    "border_focus":"#BD93F9",
    "border_width":1,
    "new_client_position":"bottom",
    "single_border_width":0,
}

layouts = [
    layout.MonadTall(
        **layout_default_args
    ),
    layout.MonadWide(
        **layout_default_args
    ),
    layout.Bsp(
        fair=False,
        **layout_default_args
    ),
]

bar_color = "#222255"
widget_defaults = dict(
    font="sans",
    fontsize=14,
    rounded=True,
    padding=4,
    background=bar_color
)
extension_defaults = widget_defaults.copy()

groupbox = widget.GroupBox(
    center_aligned=True,
    this_current_screen_border="#EEEEFF",
    active="#7777BB",
    background="#000000.0",
    fontsize=12,
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.Memory(format='{MemUsed: .0f} {mm}'),
                widget.Sep(),
                widget.ThermalSensor(),
                widget.TextBox("", 
                               foreground=bar_color, 
                               background="#000000.0",
                               padding=0,
                               fontshadow=bar_color,
                               fontsize=16),
                widget.Spacer(background="#000000.0"),
                groupbox,
                widget.Spacer(background="#000000.0"),
                widget.TextBox("", 
                               foreground=bar_color, 
                               background="#000000.0",
                               fontshadow=bar_color,
                               padding=0,
                               fontsize=16),
                widget.Battery(not_charging_char=""),
                widget.GenPollCommand(
                    cmd="/home/dns/.config/wm/scripts/charge_cycles_per_day.sh",
                    foreground="#AAAAAA",
                    update_interval=3600
                ),
                widget.Sep(),
                widget.Clock(format="%Y-%m-%d %a %I:%M %p"),
            ],
            20,
            background="#000000.0",
            opacity=1,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(wm_class="pinentry-gtk-2"),  # GPG key password entry
        Match(wm_class="com.cisco.anyconnect.gui"),  # GPG key password entry
        Match(wm_class="Tk"), # Tkinter stuff.
        Match(wm_class="Toplevel"), # Tkinter stuff.
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = None

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"

#@hook.subscribe.setgroup
# def change_group():
#    screens[0].bottom.show(False)

