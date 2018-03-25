import sqlite3
import json
import os
import sys
import getopt
import subprocess
import math
import time


def main(argv):
    try:
        opts, args = getopt.getopt(argv, "hi:")
    except getopt.GetoptError:
        print(f"command_import.py -i <input-file>")
        sys.exit(2)

    input_file = ""
    for opt, arg in opts:
        if opt == "-h":
            print(f"command_import.py -i <input-file>")
            sys.exit()
        elif opt in ("-i", "input"):
            input_file = arg

    if input_file == "":
        print(f"Input file required: command_import.py -i <input-file>")
        sys.exit(2)

    with open(input_file, 'r') as f:
        commands = json.load(f)

        username = subprocess.check_output(
            "whoami", shell=True).strip().decode("utf-8")

        database_file = os.path.expanduser(f"~/Library/Application Support/Dragon/Commands/{username}.ddictatecommands")
        with sqlite3.connect(database_file) as conn:
            c = conn.cursor()
            last_command = math.floor(time.time())

            c.execute("BEGIN TRANSACTION;")
            c.execute("DELETE FROM ZTRIGGER;")
            c.execute("DELETE FROM ZACTION;")
            c.execute("DELETE FROM ZCOMMAND;")
            c.execute("COMMIT TRANSACTION;")

            for command in commands:
                c.execute("SELECT Z_PK FROM ZTRIGGER ORDER BY Z_PK DESC LIMIT 1")
                pk = c.fetchone()
                if pk is not None:
                    curr_id = pk[0]
                else:
                    curr_id = 0
                id = curr_id + 1

                command_id = last_command
                last_command += 1

                c.execute("BEGIN TRANSACTION;")
                c.execute(f"INSERT INTO ZTRIGGER (Z_ENT, Z_OPT, ZISUSER, ZCOMMAND, ZCURRENTCOMMAND, ZDESC, ZSPOKENLANGUAGE, ZSTRING) VALUES (4, 1, 1, {id}, {id}, 'mu', 'en_AU','{command}');")
                c.execute(f"INSERT INTO ZACTION (Z_ENT, Z_OPT, ZISUSER, ZCOMMAND, ZCURRENTCOMMAND, ZOSLANGUAGE, ZTEXT) VALUES (1, 1, 1, {id}, {id}, 'en_US', 'echo -e \"{command}\" | nc -U /tmp/mu.sock');")
                c.execute(f"INSERT INTO ZCOMMAND(Z_ENT, Z_OPT, ZACTIVE, ZAPPVERSION, ZCOMMANDID, ZDISPLAY, ZENGINEID, ZISCOMMAND, ZISCORRECTION, ZISDICTATION, ZISSLEEP, ZISSPELLING, ZVERSION, ZCURRENTACTION, ZCURRENTTRIGGER, ZLOCATION, \
                  ZAPPBUNDLE, ZOSLANGUAGE, ZSPOKENLANGUAGE, ZTYPE, ZVENDOR) VALUES (2, 4, 1, 0, {command_id}, \
                  1, -1, 1, 0, 0, 0, 1, 1, {id}, {id}, NULL, NULL, 'en_US', 'en_AU', 'ShellScript', '{username}');")

                c.execute(
                    f"UPDATE Z_PRIMARYKEY SET Z_MAX = {id} WHERE Z_NAME = 'action'")
                c.execute(
                    f"UPDATE Z_PRIMARYKEY SET Z_MAX = {id} WHERE Z_NAME = 'trigger'")
                c.execute(
                    f"UPDATE Z_PRIMARYKEY SET Z_MAX = {id} WHERE Z_NAME = 'command'")
                c.execute("COMMIT TRANSACTION;")

            for command in commands:
                c.execute("SELECT Z_PK FROM ZTRIGGER ORDER BY Z_PK DESC LIMIT 1")
                pk = c.fetchone()
                if pk is not None:
                    curr_id = pk[0]
                else:
                    curr_id = 0
                id = curr_id + 1

                command_id = last_command
                last_command += 1

                c.execute("BEGIN TRANSACTION;")
                c.execute(f"INSERT INTO ZTRIGGER (Z_ENT, Z_OPT, ZISUSER, ZCOMMAND, ZCURRENTCOMMAND, ZDESC, ZSPOKENLANGUAGE, ZSTRING) VALUES (4, 1, 1, {id}, {id}, 'mu', 'en_AU','{command} /!Text!/');")
                c.execute(f"INSERT INTO ZACTION (Z_ENT, Z_OPT, ZISUSER, ZCOMMAND, ZCURRENTCOMMAND, ZOSLANGUAGE, ZTEXT) VALUES (1, 1, 1, {id}, {id}, 'en_US', 'echo -e \"{command} ${{varText}}\" | nc -U /tmp/mu.sock');")
                c.execute(f"INSERT INTO ZCOMMAND(Z_ENT, Z_OPT, ZACTIVE, ZAPPVERSION, ZCOMMANDID, ZDISPLAY, ZENGINEID, ZISCOMMAND, ZISCORRECTION, ZISDICTATION, ZISSLEEP, ZISSPELLING, ZVERSION, ZCURRENTACTION, ZCURRENTTRIGGER, ZLOCATION, \
                  ZAPPBUNDLE, ZOSLANGUAGE, ZSPOKENLANGUAGE, ZTYPE, ZVENDOR) VALUES (2, 4, 1, 0, {command_id}, \
                  1, -1, 1, 0, 0, 0, 1, 1, {id}, {id}, NULL, NULL, 'en_US', 'en_AU', 'ShellScript', '{username}');")

                c.execute(
                    f"UPDATE Z_PRIMARYKEY SET Z_MAX = {id} WHERE Z_NAME = 'action'")
                c.execute(
                    f"UPDATE Z_PRIMARYKEY SET Z_MAX = {id} WHERE Z_NAME = 'trigger'")
                c.execute(
                    f"UPDATE Z_PRIMARYKEY SET Z_MAX = {id} WHERE Z_NAME = 'command'")
                c.execute("COMMIT TRANSACTION;")
            conn.commit()


if __name__ == "__main__":
    main(sys.argv[1:])
