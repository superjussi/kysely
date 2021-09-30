import 'dart:html';
import 'dart:convert';

main() async {
  var osoite = 'kysymykset.json';
  var sisalto = await HttpRequest.getString(osoite);
  var sanakirja = jsonDecode(sisalto);

  var kysymykset = sanakirja['kysymykset'];
  querySelector('#seuraava').onClick.listen((e) {
    kysymykset.shuffle();
    asetaKysymys(kysymykset[0]);
  });
}

asetaKysymys(kysymys) {
  asetaKysymysteksti(kysymys['teksti']);
  asetaVastausvaihtoehdot(kysymys['vaihtoehdot']);
}

asetaKysymysteksti(teksti) {
  querySelector('#kysymys').text = teksti;
}

asetaVastausvaihtoehdot(vaihtoehdot) {
  querySelector('#vastaukset').children.clear();
  for (var i = 0; i < vaihtoehdot.length; i++) {
    lisaaVastausvaihtoehto(vaihtoehdot[i]);
  }
}

lisaaVastausvaihtoehto(vaihtoehto) {
  var elementti = Element.div();
  elementti.className = 'vaihtoehto';
  elementti.text = vaihtoehto['teksti'];
  elementti.onClick.listen((e) {
    if (vaihtoehto['oikein']) {
      elementti.text = 'rätt!';
    } else {
      elementti.text = 'fel!';
    }
  });
  querySelector('#vastaukset').children.add(elementti);
}
