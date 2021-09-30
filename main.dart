import 'dart:html';
import 'dart:convert';

main() async {
  //var osoite = 'https://csfoundations.cs.aalto.fi/json-data/kysymykset.json';
  var osoite = 'https://opentdb.com/api.php?amount=10';
  var sisalto = await HttpRequest.getString(osoite);
  var sanakirja = jsonDecode(sisalto);
  var kysymykset = sanakirja['results'];
  kysymykset.shuffle();
  var i = kysymykset.length - 1;
  querySelector('#seuraava').onClick.listen((e) {
    //kysymykset.shuffle();
    asetaKysymys(kysymykset[i]);
    i--;
    if (i == 0) {
      i = kysymykset.length - 1;
    }
  });
}

asetaKysymys(kysymys) {
  asetaKysymysteksti(kysymys['question']);
  asetaVastausvaihtoehdot(kysymys);
}

asetaKysymysteksti(teksti) {
  querySelector('#kysymys').text = teksti;
}

asetaVastausvaihtoehdot(vaihtoehdot) {
  querySelector('#vastaukset').children.clear();

  var wronganswers = vaihtoehdot['incorrect_answers'];
  var answers = [];

  answers.add({'teksti': vaihtoehdot['correct_answer'], 'oikein': true});

  for (var i = 0; i < wronganswers.length; i++) {
    answers.add({'teksti': wronganswers[i], 'oikein': false});
  }

  answers.shuffle();

  for (var i = 0; i < answers.length; i++) {
    lisaaVastausvaihtoehto(answers[i]);
  }
}

lisaaVastausvaihtoehto(vaihtoehto) {
  var elementti = Element.div();
  elementti.className = 'vaihtoehto';
  elementti.text = vaihtoehto['teksti'];
  elementti.onClick.listen((e) {
    if (vaihtoehto['oikein']) {
      elementti.text = 'CORRECT!';
    } else {
      elementti.text = 'WROOOONG!';
    }
  });
  querySelector('#vastaukset').children.add(elementti);
}
