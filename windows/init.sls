windows minion:
  group:
    - present
  user:
    - present
    - groups:
      - windows minion
    - require:
      - group: windows minion

