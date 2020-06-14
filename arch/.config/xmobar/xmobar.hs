-- http://projects.haskell.org/xmobar/
-- install xmobar with these flags: --flags="with_alsa" --flags="with_mpd" --flags="with_xft"  OR --flags="all_extensions"
-- you can find weather location codes here: http://weather.noaa.gov/index.html

Config {
       -- appearance
         font    = "xft:FiraMono Nerd Font:pixelsize=21:antialias=true:hinting=true"
       , additionalFonts = [ "xft:FontAwesome:pixelsize=16" ]
       , bgColor = "#282A36"
       , fgColor = "#B45BCF"
       , position = Top

       -- general behavior
       , lowerOnStart = True
       , hideOnStart = False
       , allDesktops = True
       , pickBroadest =     False   -- choose widest display (multi-monitor)
       , persistent = True
       , commands = [
                      -- Time and date
                      Run Date "%a %b %d %H:%M:%S" "date" 10
                      -- Network up and down
                    , Run DynNetwork  ["-t", "\xf0aa <rx>kb \xf0ab <tx>kb"] 10
                      -- Cpu usage in percent
                    , Run Cpu ["-t", "\xf108  <total>%","50","--high","red"] 20
                      -- Core Temprature
                    , Run CoreTemp ["-t", "<core0>", "80", "--high", "red"] 50
                      -- Ram used number and percent
                    , Run Memory ["-t", " <availableratio>% free"] 20
                      -- Disk space free
                    , Run DiskU [("/", "\xf0c7 <free>")] [] 60
                      -- Prints out the left side items such as workspaces, layout, etc.
                      -- The workspaces are 'clickable' in my configs.
                    , Run Battery [ "-t", "<acstatus>"

                                  , "--" -- battery specific options
                                       -- discharging status
                                       , "-o"	, "  <left>% (<timeleft>)"
                                       -- AC "on" status
                                       , "-O"	, " <left>%"
                                       -- fully charged
                                       , "-i"	, " 100%"
                                  ] 50
                    , Run UnsafeStdinReader
                    ]
       , sepChar = "%"
       , alignSep = "}{"
       , template = "<fc=#ffffff>  </fc>%UnsafeStdinReader% }{<fc=#666666>| </fc>%battery% <fc=#666666>| </fc><fc=#FFB86C>%cpu% </fc><fc=#666666>| </fc><fc=#ffff22>%coretemp%糖 </fc><fc=#666666>| </fc><fc=#FF5555>%memory% </fc><fc=#666666>| </fc><fc=#82AAFF>%disku% </fc><fc=#666666>| </fc><fc=#c3e88d>%dynnetwork% </fc><fc=#666666>| </fc><fc=#8BE9FD>%date%</fc> "
       }
