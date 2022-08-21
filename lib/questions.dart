class Question
{
  String question;
  String option_a;
  String option_b; 
  String option_c;
  String answer;

  Question({
    required this.question,
    required this.option_a,
    required this.option_b,
    required this.option_c,
    required this.answer,
  });

  static Question fromJson(Map<String, dynamic> json) => Question(
    question: json['question'],
    option_a: json['option_a'],
    option_b: json['option_b'],
    option_c: json['option_c'],
    answer: json['answer']
  );
}


 