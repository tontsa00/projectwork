# Projectwork
Palvelinten hallinnan kurssin projekti
Projektityössäni, luon salt moduulin, joka asentaisi työaseman ohjelmat, konfiguroi ohjelmien oletus asetukset määrittämilläni 
asetuksilla. Käytän h1 tehtävässä luotua DigitalOcean palvelintani joka toimii salt-masterina.
Salt-masterilla suoritan moduulini, joka asentaa Windows sekä Xubuntu käyttöjärjestelmille työaseman tarvittavat ohjelmat, 
eli tekstinkäsittely ohjelman LibreOffice, sähköpostiohjelman Thunderbird, kuvankäsittelyohjelman GIMP, Firefox www-selain ohjelman 
sekä muitakin työaseman 
yleisiä ohjelmia,mitä työpaikoilla tai oppilaitoksissa käytetään. Tämän lisäksi luon vagrant virtualisointi ohjelmalla Xubuntu
tietokoneelle useita virtuaalisia orjia. Tavoitteena olisi, että moduulillani, 
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
  'windows 10 minion':
    - windows
  'xubuntu minion':
    - xubuntu

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

Jatoin projektia asentamalla ohjelmia saltilla.


Asensin seuraavat ohjelmat molemmille minioneille:

Firefox www-selain

Thunderbird sähköpostiohjelma

Gimp kuvankäsittelyohjelma

VLC multimedia soitin ohjelma

7zip pakkaushallintaohjelma

Git Github repository ohjelman

Adobe Reader ohjelman asennus ei onnistunut Xubuntu minionille, mutta windows 10 minionille asennus onnistui.
Asensin sen sijaan Calibre pdf luku ohjelman Xubuntu minionille.
LibreOffice toimisto ohjelmat asentuivat Xubuntu minionille, mutta ei Windows minionille.
Asensin LibreOffice ohjelman manuaalisesti lataamalla ohjelman Windows minionillani osoitteesta: https://fi.libreoffice.org/.

Ohjelmien asentamisen jälkeen, määritin asetukset valmiiksi vain Firefox www-selaimelle, koska muihin ohjelmiin annan käyttäjien itse
valita mieleisensä asetukset.

Aloitin etsimällä ensin Windows minionillani käyttäjä asetukset, jotka löytyivät kansiosta 
C:\Users\tonts\AppData\Roaming\Mozilla\Firefox\Profiles\isc998ku.default-1551160940498 pref.js tiedostosta.

Xubuntu minionillani asetus tiedosto löytyi kansiosta ~/.mozilla/firefox/b6w20qxd.default prefs.js tiedostosta myöskin.

Kopion Windows 10 minionillani pref.js asetus tiedoston DigitalOcean salt-master palvelimelleni.

Sekä tein saman myöx Xubuntu minionillani, eli kopioin pref.js asetus tiedoston DigitalOCean palvelimelleni.

Loin kaksi kansiota nimeltään windowsasetukset sekä xubuntuasetukset ja loin kansioihin tiedostot init.sls, joihin kirjoitin:

windowsasetukset init.sls:

C:\Users\tonts\AppData\Roaming\Mozilla\Firefox\Profiles\isc998ku.default-1551160940498\prefs.js:
  file.managed:
    - source: salt://projectwork/windowsasetukset/prefs.js

xubuntuasetukset init.sls:

~/.mozilla/firefox/b6w20qxd.default/prefs.js
  file.managed:
    - source: salt//projectwork/xubuntuasetukset/prefs.js

Kumpaankin asetustiedostoon muutin kotisivuksi Haaga-Helian App sivun, mistä voi kätevästi löytää kaikki opiskelijan tarvitsevat sivustot.

top.sls tiedostoon lisäsin - windowsasetukset sekä - xubuntuasetukset, eli kummankin minionia varten määritetyt asetus tiedosto kansiot mitkä loin.

Kun olin komennolla sudo salt '*' state.highstate suorittanut tilan ajon, tarkistin Firefox selaimen kotisivun, ja huomasin, ettää uusi kotisivu oli
muuttunut osoitteeksi hhapp.info mikä oli tarkoituskin.

Ainoastaan xubuntu minionilla ei kotisivun muutosto tapahtunut, koska sain virheilmoituksen:

 ID: ~/.mozilla/firefox/b6w20qxd.default/prefs.js
    Function: file.managed
      Result: False
     Comment: Parent directory not present
     Started: 19:18:58.867559
    Duration: 275.096 ms
     Changes:   

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
path = /home/username/sambashare
read only = no
browsable = yes

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

Sekä kohdassa, write list = root, @lpadmin, @toni, @tonts, @tontsa00, lisäsin käyttäjänimet @toni, @tonts sekä @tontsa00.
Kaiken tämän jälkeen avasin Windows minion tietokoneellani Windows+E pikanäppäin komennolla Resurssien hallinnan
ja kirjoitin osoite kenttään \\tontsaoo.me\sambashare tai \\104.248.143.181\sambashare jolloin sain auki sambashare kansion sisällön ja näin kaksi tekemääni tiedostoa kansiossa.


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
