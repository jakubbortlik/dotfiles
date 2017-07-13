# lxpanel <profile> config file. Manually editing is not recommended.
# Use preference dialog in lxpanel to adjust config when you can.

Global {
  edge=top
  allign=left
  margin=0
  widthtype=percent
  width=100
  height=26
  transparent=0
  tintcolor=#000000
  alpha=0
  setdocktype=1
  setpartialstrut=1
  usefontcolor=1
  fontcolor=#ffffff
  background=1
  backgroundfile=/usr/share/lxpanel/images/background.png
  autohide=0
}
Plugin {
  type=space
  Config {
    Size=2
  }
}
Plugin {
  type=menu
  Config {
    image=/usr/share/lxde/images/lxde-icon.png
    system {
    }
    separator {
    }
    item {
      command=run
    }
    separator {
    }
    item {
      image=gnome-logout
      command=logout
    }
  }
}
Plugin {
  type=launchbar
  Config {
    Button {
      id=pcmanfm.desktop
    }
    Button {
      id=firefox.desktop
    }
  }
}
Plugin {
  type=space
  Config {
    Size=4
  }
}
Plugin {
  type=wincmd
  Config {
    Button1=iconify
    Button2=shade
  }
}
Plugin {
  type=space
  Config {
    Size=4
  }
}
Plugin {
  type=pager
  Config {
  }
}
Plugin {
  type=space
  Config {
    Size=4
  }
}
Plugin {
  type=taskbar
  expand=1
  Config {
    tooltips=1
    IconsOnly=0
    AcceptSkipPager=1
    ShowIconified=1
    ShowMapped=1
    ShowAllDesks=0
    UseMouseWheel=1
    UseUrgencyHint=1
    FlatButton=1
    MaxTaskWidth=150
    spacing=1
    SameMonitorOnly=0
    GroupedTasks=0
    DisableUpscale=0
  }
}
Plugin {
  type=cpu
  Config {
  }
}
Plugin {
  type=xkb
  Config {
    Model=pc105
    LayoutsList=us_jb,ipa,cz_jb
    VariantsList=,,
    ToggleOpt=grp:shifts_toggle,grp:shift_caps_toggle,grp_led:scroll
    KeepSysLayouts=0
    FlagSize=5
  }
}
Plugin {
  type=batt
  Config {
    BackgroundColor=black
    ChargingColor1=#28f200
    ChargingColor2=#22cc00
    DischargingColor1=#ffee00
    DischargingColor2=#d9ca00
    HideIfNoBattery=0
    AlarmCommand=xmessage Battery low
    AlarmTime=10
    BorderWidth=1
    Size=10
    ShowExtendedInformation=0
    BatteryNumber=0
  }
}
Plugin {
  type=tray
  Config {
  }
}
Plugin {
  type=dclock
  Config {
    ClockFmt=%a, %d %b %R
    TooltipFmt=%A %x
    BoldFont=0
    IconOnly=0
    CenterText=0
  }
}
Plugin {
  type=launchbar
  Config {
    Button {
      id=lxde-screenlock.desktop
    }
    Button {
      id=lxde-logout.desktop
    }
  }
}
