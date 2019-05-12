users:
  windows minion:
    fullname: Windows Minion
    uid: 5000
    gid: 5000
    shell: /bin/bash
    home: /home/user1
    groups:
      - Minions
      - admin
    password: $6$SALTsalt$UiZikbV3VeeBPsg8./Q5DAfq9aj7CVZMDU6ffBiBLgUEpxv7LMXKbcZ9JSZnYDrZQftdG319XkbLVMvWcF/Vr/
    enforce_password: True
    key.pub: True
