import 'package:flutter/material.dart';
import 'package:true_false/pages/score_page.dart';
import 'package:true_false/ui/question_text.dart';
import 'package:true_false/utils/question.dart';
import 'package:true_false/utils/quiz.dart';
import 'package:true_false/ui/answer_button.dart';
import 'package:true_false/ui/correct_wrong_overlay.dart';

class QuizPage extends StatefulWidget {
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage> {
  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("İnsan DNA'sı %50 oranında salatalık DNA'sı ile aynıdır.", false),
    new Question("Ahtapotların 3 tane kalbi vardır.", true),
    new Question("'Abrakadabra' sözcüğü, ilk olarak yüksek ateşli hastaların, ateşlerini düşürmek için söylenmiştir.", true),
    new Question("Altın en iyi iletkendir.", false),
    new Question("Kanımızın vücudumuzu dolaşması yalnızca 22-23 saniye sürüyor.", true),
    new Question("Fransa'da giyotinle en son idam 1977 yılında yapılmıştır.", true),
    new Question("Dünyadaki en kısa savaş 2 saat sürmüştür.", false),
    new Question("İran ordusu, 2007 yılında 14 sincabı ajan oldukları gerekçesiyle tutukladı.", true),
    new Question("İran'ın yüzölçümü Türkiye'nin yüzölçümünden büyüktür.", true),
    new Question("Chicago, Barcelona, Roma ve İstanbul, aynı enlem üzerindedir.", true),
    new Question("Avrupa'nın en kalabalık şehri İstanbul'dur.", true),
    new Question("Namaz, Arapça kökenli bir kelimedir.", false),
    new Question("Dinozorlar olmasaydı kuşlar olmazdı.", true),
    new Question("Aynı anda nefes alman ve yutkunman mümkün değildir.", true),
    new Question("Barcelona, İspanya'nın başkentidir.", false),
    new Question("Uganda'da yaşayan Buganda insanları Luganda konuşur.", true),    
    new Question("Tweety'nin cinsiyeti erkektir!", true),
    new Question("-1,1 sayısı -1,01'den daha büyüktür.", false),
    new Question("Dünyadaki tüm yeni doğmuş bebekler La notasıyla ağlar.", true),
    new Question("Bazı filler popolarından nefes alabilirler.", false),
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool overlayShouldBeVisible = false;

  @override
  void initState() {
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void handleAnswer(bool answer) {
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      overlayShouldBeVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Column(
          children: <Widget>[
            AnswerButton(true, () {
              handleAnswer(true);
            }),
            QuestionText(questionText, questionNumber),
            AnswerButton(false, () {
              handleAnswer(false);
            })
          ],
        ),
        overlayShouldBeVisible
            ? CorrectWrongOverlay(isCorrect, () {
                currentQuestion = quiz.nextQuestion;
                if(currentQuestion == null){
                  Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) => ScorePage(quiz.score,quiz.questions.length)));
                }
                this.setState(() {
                  overlayShouldBeVisible = false;
                  questionText = currentQuestion.question;
                  questionNumber = quiz.questionNumber;
                });
              })
            : Container()
      ],
    );
  }
}
