base:
  '*windows 10 minion*':
    - match: glob
    - windows
    - windowsasetukset

  '*xubuntu minion*':
    - match: glob
    - xubuntu
    - xubuntuasetukset
