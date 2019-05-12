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
