xubuntu minion:
  group:
    - present
  user:
    - present
    - groups:
      - xubuntu minion
    - require:
- group: xubuntu minion
