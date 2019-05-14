# Projectwork
Palvelinten hallinnan kurssin projekti
Projektityössäni, luon salt moduulin, joka asentaisi työaseman ohjelmat, konfiguroi ohjelmien oletus asetukset määrittämilläni 
asetuksilla. Käytän h1 tehtävässä luotua DigitalOcean palvelintani joka toimii salt-masterina.
Salt-masterilla suoritan moduulini, joka asentaa Windows sekä Xubuntu käyttöjärjestelmille työaseman tarvittavat ohjelmat, 
eli tekstinkäsittely ohjelman LibreOffice, sähköpostiohjelman Thunderbird, kuvankäsittelyohjelman GIMP, Firefox www-selain ohjelman 
sekä muitakin työaseman 
yleisiä ohjelmia,mitä työpaikoilla tai oppilaitoksissa käytetään. Tavoitteena olisi, että moduulillani, 
kuka tahansa voi asentaa useille työasema tietokoneille oletus ohjelmat, 
ohjelmien asetukset olisi ennalta määritetty sekä kaikki työasemat 
olisivat valmiina käytössä.

Olen jo etukäteen tehnyt valmistelu projektilleni.

Määritin käyttöön GitHub repository varaston windows repository varaston käyttöön Saltstack ohjeiden mukaan:
https://docs.saltstack.com/en/latest/topics/windows/windows-package-manager.html.

Minionit projektissani ovat windows 10 minion, Windows 10 läppärilläni sekä xubuntu minion, xubuntu tietokoneellani.

Windows 10 minionin latasin osoitteesta: https://repo.saltstack.com/windows/Salt-Minion-2017.7.4-Py3-AMD64-Setup.exe
ja asensin ohjelman Windows 10 läppärilläni.

Xubuntun minionin asensin xubuntun terminaalissa komennoilla 
sudo apt-get update sekä sudo apt-get install -y salt-minion.
Tämän lisäksi käynnistin salt-minion palvelun uudestaan, sudo systemctl restart salt-minion komennolla.

Projektissani käytin Windows 10 läppäriä, mille loin uudet käyttäjät saltilla, asensin ohjelmat sekä määritin ohjelmien
asetukset saltilla valmiiksi.

Tämän lisäksi käytin Xubuntua jolle tein samat määritykset kuin Windows 10 läppärilleni.

Määritin myös Samballa yhteisen kansion DigitalOcean palvelimeltani kummankin minionin yhteiseen käyttöön.

Alotin projektityön luomalla uudet käyttäjät windows 10 sekä xubuntu minion orjille. Määritin Windows 10 minionille käyttäjänimen windows minion sekä
Xubuntu minionille xubuntu minion käyttäjänimen.

top.sls tiedostoon kirjoitin
base:
  '*windows 10 minion*':
    - match: glob
    - windowsuser
    - windowsohjelmat
    - windowsasetukset

  '*xubuntu minion*':
    - match: glob
    - xubuntuuser
    - xubuntuohjelmat
    - xubuntuasetukset

Loin myös kansiot windows sekä xubuntu, sudo mkdir windows/xubuntu komennoilla. Kansioihin loin init.sls state tila tiedostot, sekä
kirjoitin init.sls tiedostoihin:

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

sekä

users:
  xubuntu minion:
    fullname: Xubuntu Minion
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

Lopuksi ajoin komennon sudo salt '*' state.highstate

Sain tulokseksi:

xubuntu minion:
    Data failed to compile:
----------
    No matching sls found for 'users' in env 'base'
windows 10 minion:
    Data failed to compile:
----------
    No matching sls found for 'users' in env 'base'

Eli en pystynyt luomaan uusia käyttäjiä minioneilleni.

Selvitin mitä nämä virheet tarkoittivat, kuitenkin tuloksetta tai en en tiennyt mistä löytää apua ongelmaani.

Tämän johdosta poistin top.sls tiedostosta kohdat windowsuser sekä xubuntuuser.


Jatkoin projektia asentamalla ohjelmia saltilla sekä tekemällä asetus muutokset Firefox selaimeen.


Asensin seuraavat ohjelmat molemmille minioneille:

Firefox www-selain

Thunderbird sähköpostiohjelma

Gimp kuvankäsittelyohjelma

VLC multimedia soitin ohjelma

7zip pakkaushallintaohjelma

Git Github repository ohjelman

Nautilus ohjelman samba jaetun kansion käyttöä varten xubuntu minionille

Asetus muutokset tein Firefox www selain ohjelmalle.

Aloitin etsimällä ensin Windows minionillani käyttäjä asetukset, jotka löytyivät kansiosta 
C:\Users\tonts\AppData\Roaming\Mozilla\Firefox\Profiles\isc998ku.default-1551160940498 pref.js tiedostosta.

Xubuntu minionillani asetus tiedosto löytyi kansiosta /home/xubuntu/.mozilla/firefox/a0bcvy9q.default prefs.js tiedostosta myöskin.

Kopioin Windows 10 minionillani pref.js asetus tiedoston DigitalOcean salt-master palvelimelleni.

Sekä tein saman myöx Xubuntu minionillani, eli kopioin pref.js asetus tiedoston DigitalOCean palvelimelleni.

Loin kaksi kansiota nimeltään windowsasetukset sekä xubuntuasetukset ja loin kansioihin tiedostot init.sls, joihin kirjoitin:

windowsasetukset init.sls:

C:\Users\tonts\AppData\Roaming\Mozilla\Firefox\Profiles\isc998ku.default-1551160940498\prefs.js:
  file.managed:
    - source: salt://windowsasetukset/prefs.js

xubuntuasetukset init.sls:

/home/xubuntu/.mozilla/firefox/a0bcvy9q.default/prefs.js
  file.managed:
    - source: salt//xubuntuasetukset/prefs.js

Kumpaankin asetustiedostoon muutin kotisivuksi Haaga-Helian App sivun, mistä voi kätevästi löytää kaikki opiskelijan tarvitsevat sivustot.

top.sls tiedostoon lisäsin - windowsasetukset sekä - xubuntuasetukset, eli kummankin minionia varten määritetyt asetus tiedosto kansiot mitkä loin.
Lopullisesti top.sls state tiedosto näytti tältä:

base:
  '*windows 10 minion*':
    - match: glob
    - windowsohjelmat
    - windowsasetukset

  '*xubuntu minion*':
    - match: glob
    - xubuntuohjelmat
    - xubuntuasetukset

Suoritin komennon sudo salt '*' state.highstate kahteen kertaan, varmistaakseni sen, että kaikki ohjelmat ja asetus muutokset menivät
varmasti läpi. Komento sudo salt '*' state.highstate ajoin top.sls state tilan joka suoritti salt-master käskyn molemmille minioneille.

Tulokeksi sain:

xubuntu minion:
----------
          ID: install_firefox
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.145834
    Duration: 332.73 ms
     Changes:   
----------
          ID: install_thunderbird
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.478678
    Duration: 2.809 ms
     Changes:   
----------
          ID: install_libreoffice
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.481551
    Duration: 2.627 ms
     Changes:   
----------
          ID: install_gimp
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.484240
    Duration: 2.641 ms
     Changes:   
----------
          ID: install_vlc
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.486942
    Duration: 2.613 ms
     Changes:   
----------
          ID: install_p7zip
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.489616
    Duration: 2.644 ms
     Changes:   
----------
          ID: install_git
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.492320
    Duration: 2.644 ms
     Changes:   
----------
          ID: install_calibre
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.495026
    Duration: 2.619 ms
     Changes:   
----------
          ID: install_nautilus
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 11:37:26.497705
    Duration: 2.642 ms
     Changes:   
----------
          ID: /home/xubuntu/.mozilla/firefox/a0bcvy9q.default/prefs.js
    Function: file.managed
      Result: True
     Comment: File /home/xubuntu/.mozilla/firefox/a0bcvy9q.default/prefs.js is in the correct state
     Started: 11:37:26.502572
    Duration: 280.115 ms
     Changes:   

Summary for xubuntu minion
-------------
Succeeded: 10
Failed:     0
-------------
Total states run:     10
Total run time:  634.084 ms
windows 10 minion:
----------
          ID: install_firefox
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 14:37:32.939919
    Duration: 42497.948 ms
     Changes:   
----------
          ID: install_thunderbird
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 14:38:15.437867
    Duration: 46.849 ms
     Changes:   
----------
          ID: install_libreoffice
    Function: pkg.installed
      Result: False
     Comment: An exception occurred in this state: Traceback (most recent call last):
                File "c:\salt\bin\lib\site-packages\salt\state.py", line 1851, in call
                  **cdata['kwargs'])
                File "c:\salt\bin\lib\site-packages\salt\loader.py", line 1795, in wrapper
                  return f(*args, **kwargs)
                File "c:\salt\bin\lib\site-packages\salt\states\pkg.py", line 1627, in installed
                  **kwargs)
                File "c:\salt\bin\lib\site-packages\salt\modules\win_pkg.py", line 1208, in install
                  cached_pkg = __salt__['cp.cache_file'](installer, saltenv)
                File "c:\salt\bin\lib\site-packages\salt\modules\cp.py", line 474, in cache_file
                  result = _client().cache_file(path, saltenv)
                File "c:\salt\bin\lib\site-packages\salt\fileclient.py", line 189, in cache_file
                  return self.get_url(path, '', True, saltenv, cachedir=cachedir)
                File "c:\salt\bin\lib\site-packages\salt\fileclient.py", line 701, in get_url
                  raise MinionError('Error: {0} reading {1}'.format(query['error'], url))
              salt.exceptions.MinionError: Error: HTTP 503: Service Temporarily Unavailable reading https://downloadarchive.documentfoundation.org/libreoffice/old/6.0.5.2/win/x86_64/LibreOffice_6.0.5.2_Win_x64.msi
     Started: 14:38:15.484716
    Duration: 327.94 ms
     Changes:   
----------
          ID: install_gimp
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 14:38:15.812656
    Duration: 46.849 ms
     Changes:   
----------
          ID: install_vlc
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 14:38:15.859505
    Duration: 78.08 ms
     Changes:   
----------
          ID: install_adobereader
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 14:38:15.937585
    Duration: 46.852 ms
     Changes:   
----------
          ID: install_7zip
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 14:38:15.984437
    Duration: 46.846 ms
     Changes:   
----------
          ID: install_git
    Function: pkg.installed
      Result: True
     Comment: All specified packages are already installed
     Started: 14:38:16.031283
    Duration: 46.848 ms
     Changes:   
----------
          ID: C:\Users\tonts\AppData\Roaming\Mozilla\Firefox\Profiles\isc998ku.default-1551160940498\prefs.js
    Function: file.managed
      Result: True
     Comment: File C:\Users\tonts\AppData\Roaming\Mozilla\Firefox\Profiles\isc998ku.default-1551160940498\prefs.js updated
     Started: 14:38:16.093748
    Duration: 124.929 ms
     Changes:   
              ----------
              diff:
                  --- 
                  +++ 
                  @@ -29,7 +29,6 @@
                   user_pref("app.update.lastUpdateTime.telemetry_modules_ping", 1557659974);
                   user_pref("app.update.lastUpdateTime.xpi-signature-verification", 1557659854);
                   user_pref("app.update.migrated.updateDir2.308046B0AF4A39CB", true);
                  -user_pref("app.update.migrated.updateDir2.E7CF176E110C211B", true);
                   user_pref("browser.bookmarks.showMobileBookmarks", false);
                   user_pref("browser.cache.disk.capacity", 1048576);
                   user_pref("browser.cache.disk.filesystem_reported", 1);
                  @@ -52,21 +51,19 @@
                   user_pref("browser.pagethumbnails.storage_version", 3);
                   user_pref("browser.places.smartBookmarksVersion", 8);
                   user_pref("browser.rights.3.shown", true);
                  -user_pref("browser.safebrowsing.provider.google4.lastupdatetime", "1557833874656");
                  -user_pref("browser.safebrowsing.provider.google4.nextupdatetime", "1557835666656");
                  -user_pref("browser.safebrowsing.provider.mozilla.lastupdatetime", "1557833875418");
                  -user_pref("browser.safebrowsing.provider.mozilla.nextupdatetime", "1557837475418");
                  +user_pref("browser.safebrowsing.provider.google4.lastupdatetime", "1557679584384");
                  +user_pref("browser.safebrowsing.provider.google4.nextupdatetime", "1557681362384");
                  +user_pref("browser.safebrowsing.provider.mozilla.lastupdatetime", "1557679585124");
                  +user_pref("browser.safebrowsing.provider.mozilla.nextupdatetime", "1557683185124");
                   user_pref("browser.search.countryCode", "FI");
                   user_pref("browser.search.region", "FI");
                  -user_pref("browser.sessionstore.resume_session_once", true);
                  -user_pref("browser.sessionstore.upgradeBackup.latestBuildID", "20190322013140");
                  -user_pref("browser.shell.didSkipDefaultBrowserCheckOnFirstRun", true);
                  +user_pref("browser.sessionstore.upgradeBackup.latestBuildID", "20190507012018");
                   user_pref("browser.shell.mostRecentDateSetAsDefault", "1557679580");
                  -user_pref("browser.slowStartup.averageTime", 0);
                  -user_pref("browser.slowStartup.samples", 0);
                  +user_pref("browser.slowStartup.averageTime", 2530);
                  +user_pref("browser.slowStartup.samples", 4);
                   user_pref("browser.startup.homepage", "hhapp.info");
                  -user_pref("browser.startup.homepage_override.buildID", "20190322013140");
                  -user_pref("browser.startup.homepage_override.mstone", "66.0.1");
                  +user_pref("browser.startup.homepage_override.buildID", "20190507012018");
                  +user_pref("browser.startup.homepage_override.mstone", "66.0.5");
                   user_pref("browser.startup.page", 3);
                   user_pref("browser.tabs.warnOnClose", false);
                   user_pref("browser.uiCustomization.state", "{\"placements\":{\"widget-overflow-fixed-list\":[],\"nav-bar\":[\"back-button\",\"forward-button\",\"stop-reload-button\",\"home-button\",\"customizableui-special-spring1\",\"urlbar-container\",\"customizableui-special-spring2\",\"downloads-button\",\"library-button\",\"sidebar-button\",\"jid1-niffy2ca8fy1tg_jetpack-browser-action\",\"_d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d_-browser-action\"],\"toolbar-menubar\":[\"menubar-items\"],\"TabsToolbar\":[\"tabbrowser-tabs\",\"new-tab-button\",\"alltabs-button\"],\"PersonalToolbar\":[\"personal-bookmarks\"]},\"seen\":[\"developer-button\",\"feed-button\",\"jid1-niffy2ca8fy1tg_jetpack-browser-action\",\"_d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d_-browser-action\",\"webide-button\"],\"dirtyAreaCache\":[\"PersonalToolbar\",\"nav-bar\",\"TabsToolbar\",\"toolbar-menubar\"],\"currentVersion\":15,\"newElementCount\":2}");
                  @@ -78,19 +75,19 @@
                   user_pref("devtools.onboarding.telemetry.logged", true);
                   user_pref("devtools.performance.recording.interval", 1000);
                   user_pref("devtools.webextensions.{d10d0bf8-f5b5-c8b4-a8b2-2b9879e08c5d}.enabled", true);
                  -user_pref("distribution.iniFile.exists.appversion", "66.0.1");
                  +user_pref("distribution.iniFile.exists.appversion", "66.0.5");
                   user_pref("distribution.iniFile.exists.value", false);
                   user_pref("dom.push.userAgentID", "65ed1609b62d495f8d6b454467ea508d");
                   user_pref("experiments.activeExperiment", false);
                   user_pref("extensions.blocklist.lastModified", "Fri, 10 May 2019 14:13:50 GMT");
                   user_pref("extensions.blocklist.pingCountTotal", 8);
                   user_pref("extensions.blocklist.pingCountVersion", -1);
                  -user_pref("extensions.databaseSchema", 28);
                  +user_pref("extensions.databaseSchema", 30);
                   user_pref("extensions.getAddons.cache.lastUpdate", 1557659614);
                   user_pref("extensions.getAddons.databaseSchema", 5);
                   user_pref("extensions.lastAppBuildId", "20190326175229");
                  -user_pref("extensions.lastAppVersion", "66.0.1");
                  -user_pref("extensions.lastPlatformVersion", "66.0.1");
                  +user_pref("extensions.lastAppVersion", "66.0.5");
                  +user_pref("extensions.lastPlatformVersion", "66.0.5");
                   user_pref("extensions.pendingOperations", false);
                   user_pref("extensions.systemAddonSet", "{\"schema\":1,\"addons\":{}}");
                   user_pref("extensions.ui.dictionary.hidden", true);
                  @@ -114,8 +111,14 @@
                   user_pref("lightweightThemes.usedThemes", "[]");
                   user_pref("media.benchmark.vp9.fps", 159);
                   user_pref("media.benchmark.vp9.versioncheck", 5);
                  +user_pref("media.gmp-gmpopenh264.abi", "x86_64-msvc-x64");
                  +user_pref("media.gmp-gmpopenh264.lastUpdate", 1551161013);
                  +user_pref("media.gmp-gmpopenh264.version", "1.7.1");
                   user_pref("media.gmp-manager.buildID", "20190507012018");
                   user_pref("media.gmp-manager.lastCheck", 1557679630);
                  +user_pref("media.gmp-widevinecdm.abi", "x86_64-msvc-x64");
                  +user_pref("media.gmp-widevinecdm.lastUpdate", 1551161978);
                  +user_pref("media.gmp-widevinecdm.version", "4.10.1146.0");
                   user_pref("media.gmp.storage.version.observed", 1);
                   user_pref("media.hardware-video-decoding.failed", false);
                   user_pref("network.cookie.cookieBehavior", 3);
                  @@ -137,7 +140,7 @@
                   user_pref("sanity-test.device-id", "0x591b");
                   user_pref("sanity-test.driver-version", "22.20.16.4749");
                   user_pref("sanity-test.running", false);
                  -user_pref("sanity-test.version", "20190322013140");
                  +user_pref("sanity-test.version", "20190507012018");
                   user_pref("security.sandbox.content.tempDirSuffix", "{6cc6052b-ce31-4924-88d1-989af0eaedbc}");
                   user_pref("security.sandbox.plugin.tempDirSuffix", "{6fb15286-859f-44f1-b072-854ec0d618c0}");
                   user_pref("services.blocklist.addons.checked", 1557658991);
                  @@ -200,8 +203,8 @@
                   user_pref("signon.importedFromSqlite", true);
                   user_pref("spellchecker.dictionary", "en-US");
                   user_pref("storage.vacuum.last.index", 0);
                  -user_pref("toolkit.startup.last_success", 1557833868);
                  +user_pref("toolkit.startup.last_success", 1557679578);
                   user_pref("toolkit.telemetry.cachedClientID", "43971cf6-4641-417d-812f-3174a0f5ec6f");
                  -user_pref("toolkit.telemetry.previousBuildID", "20190322013140");
                  +user_pref("toolkit.telemetry.previousBuildID", "20190507012018");
                   user_pref("toolkit.telemetry.reportingpolicy.firstRun", false);
                   user_pref("ui.osk.debug.keyboardDisplayReason", "IKPOS: Touch screen not found.");

Summary for windows 10 minion
------------
Succeeded: 8 (changed=1)
Failed:    1
------------
Total states run:     9
Total run time:  43.263 s
ERROR: Minions returned with non-zero exit code


Ainoastaan Windows 10 minionilla ei onnistunut LibreOffice ohjelman asennus. Selvitin virhe ilmoitusta, ja päädyin johto päätökseen, että salt ei voinut lataa LibreOffice asennus ohjelmaa osoitteesta:
https://downloadarchive.documentfoundation.org/libreoffice/old/6.0.5.2/win/x86_64/LibreOffice_6.0.5.2_Win_x64.msi. Valitettavasti en löytänyt apua mistään dokumenteista, miten olisin voinut korjata virhe ilmoitukset, joten tämän johdosta
asensin LibreOffice ohjelman manuaalisesti lataamalla ohjelman osoitteesta: https://fi.libreoffice.org/lataa/luotettavin-libreoffice/ sekä asentamalla ohjelman Windows 10 minion tietokoneellani manuaalisesti.
 

Ja ihan lopuksi loin Samba ohjelmalla uuden jaetun kansion kummankin minionin käyttöön.

Asensin samban palvelimelleni sudo apt-get install samba komennolla

whereis samba komennolla mihin samba oli asentunut, ja asennus kansio löytyikin:

/usr/sbin/samba/ /usr/lib/x86_64-linux-gnu/samba /etc/samba /usr/share/samba /usr/share/man/n8/samba.8.gz
/user/share/man/man7/samba.7.gz

Loin uuden kansion komennolla sudo mkdir /home/toni/sambashare/

Sekä muutin asetustiedostoa smb.conf komennolla sudoedit /etc/samba/smb.conf

Kirjoitin asetustiedoston loppuun:

[sambashare]
   comment = Samba on Ubuntu
   path = /home/toni/sambashare
   read only = no
   browsable= yes
   ntlm auth = yes
   guest ok = yes
   public = yes



Sekä avasin portit palomuurista samballa komennoilla_
sudo ufw allow 139/tcp
sudo ufw allow 445/tcp

Ja käynnistin samba palvelun uudestaan, sudo service smbd restart komennolla.

Loin uuden käyttäjän sudo smbpasswd -a toni komennolla ja määritin uuden keksimäni salasanan
toni käyttäjälle.

Kaiken tämän jälkeen Windows tietokoneella avasin tiedostojenhallinta ikkunan, kirjoitin osoitepalkkiin:

\\tontsa00.me\sambashare

Aluksi minulla oli vaikeuksia saada Samba toimimaan, mutta löysin apua tästä osoitteesta:
https://community.spiceworks.com/topic/2148301-samba-4-and-windows-10-file-sharing.

Asensin samban komennoilla sudo apt-get update ja sudo apt-get install samba.
Kun samba oli asentunut avasin nano editorilla samban konfiguraatio tiedoston, sudo nano /etc/samba/smb.conf.
Asetus tiedostossa lisäsin [global] kohtaan, ntlm auth = yes. Tämän lisäksi lisäsin tiedoston loppuun:

[sambashare]
   comment = Samba on Ubuntu
   path = /home/toni/sambashare
   read only = no
   browsable= yes
   ntlm auth = yes
   guest ok = yes
   public = yes



Sekä kohdassa, write list = root, @lpadmin, @toni, @tonts, @tontsa00, lisäsin käyttäjänimet @toni, @tonts sekä @tontsa00 ja @xubuntu

Kaiken tämän jälkeen avasin Windows minion tietokoneellani Windows+E pikanäppäin komennolla Resurssien hallinnan
ja kirjoitin osoite kenttään \\tontsaoo.me\sambashare tai \\104.248.143.181\sambashare jolloin sain auki sambashare kansion sisällön ja näin kaksi tekemääni tiedostoa kansiossa.

Xubuntu minionilla avasin Nautilus ohjelman, valitsin Other Locations ja kirjoitin smb://tontsa00.me/sambashare ja klikkasin Connect. 

Avautui ruutu missä oli jo valmiiksi käyttäjänimi xubuntu, sekä kirjoitin aikaisemmin luodun samba käyttäjän salasanan. Tämän jälkeen jaettu samba kansio oli käytössäni.


Olisin tämän lisäksi vielä halunnut kokeilla määrittää salt tila state komennoilla samban jaetun kansion minioneille suoraan käyttöön, mutta valitettavasti taitoni ei tähän riittäneet.

Samban lisäksi kokeilin Filezilla FTP tiedostojen jako ohjelmaa. Asensin Filezilla palvelimen minun DigitalOcean
palvelimelleni komennoilla sudo apt-get update sekä sudo apt-get install filezilla.
Tämän jälkeen noudatin ohjeita DigitalOcean sivulta: 
https://www.digitalocean.com/community/tutorials/how-to-use-filezilla-to-transfer-and-manage-files-securely-on-your-vps.

Ohjeissa pyydettiin lisäämään yksityinen SSH avainpari tiedosto Filezillaan. Minulla tätä ei ollut, joten loin Putty ohjelmalla
uuden RSA avaimen Putty Key Generator ohjelmalla. Käytin apuna ohjeita Joyent sivulta: 
https://docs.joyent.com/public-cloud/getting-started/ssh-keys/generating-an-ssh-key-manually/manually-generating-your-ssh-key-in-windows.

Avaimen luotuani lisäsin avaimen Filezilla ohjelmassa asetuksissa. Tämän tehtyä avasin Sivustonhallinta ikkunan ja loin 
uuden salt nimisen jaetun sivun. Host kohtaan kirjoitin palvelimeni ip osoitteen ja portiksi valitsin 22 sekä protokollaksi
SFTP - SSH File Transfer protokollan. Kirjautumistyypiksi valitsin interaktiivinen sekä käyttäjänimeksi palvelimeni käyttäjänimen toni.

Painoin yhdistä, kirjoitin ssh avainpariin määrittämäni salasanan ja yhteys oli luotu Filezilla ohjelmalla minun DigitalOcean palvelimelleni.


Luomani state tila tiedoston mahdollistavat uusien käyttäjien luomisen minion tietokoneille, uusien 
ohjelmien asennus minioneille sekä asetustiedostojen korvaaminen uusilla muutoksilla. Ja myöskin yhteisen
jaetun samba kansion käyttöönotto minioneille.

Opin itse uutta miten uudet käyttäjät pitäisi luode minioneille, vaikka en siinä onnistunutkaat.

Pidin kovasti projektin tekemisestä ja tulen hyödyntämään oppimaani tulevaisuudessa.
