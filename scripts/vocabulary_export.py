import json
import os
import sys
import getopt


def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hi:o:")
    except getopt.GetoptError:
        print(f"command_import.py -i <input-file> -o <output-file>")
        sys.exit(2)

    input_file = ""
    output_file = ""
    for opt, arg in opts:
        if opt == "-h":
            print(f"command_import.py -i <input-file> -o <output-file>")
            sys.exit()
        elif opt in ("-i"):
            input_file = arg
        elif opt in ("-o"):
            output_file = arg

    if input_file == "" or output_file == "":
        print(f"Input and output file required: command_import.py -i <input-file> -o <output-file>")
        sys.exit(2)

    with open(input_file, "r") as f:
        commands = json.load(f)

        words = ""
        for key in commands.keys():
            words += f"""<dict>
        <key>EngineFlags</key>
        <integer>17</integer>
        <key>Flags</key>
        <string></string>
        <key>Sense</key>
        <string></string>
        <key>Source</key>
        <string>User</string>
        <key>Spoken</key>
        <string>{key}</string>
        <key>Written</key>
        <string>{key}</string>
      </dict>"""

        with open(output_file, "w") as w:

            w.write(f"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Version</key>
    <string>3.0/1</string>
    <key>Words</key>
    <array>
    {words}
    </array>
  </dict>
</plist>
""")


if __name__ == "__main__":
    main(sys.argv[1:])


"""
<dict>
  <key>EngineFlags</key>
  <integer>17</integer>
  <key>Flags</key>
  <string></string>
  <key>Sense</key>
  <string></string>
  <key>Source</key>
  <string>User</string>
  <key>Spoken</key>
  <string>#{spoken or item}</string>
  <key>Written</key>
  <string>#{item}</string>
</dict>
"""

"""
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>Version</key>
  <string>3.0/1</string>
  <key>Words</key>
  <array>
  #{words}
  </array>
</dict>
</plist>
"""
