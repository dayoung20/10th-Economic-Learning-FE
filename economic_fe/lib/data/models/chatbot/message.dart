class Message {
  final String text;
  final bool isUserMessage; // 사용자의 메시지인지 시스템의 메시지인지 구분
  final String time; // 메시지 전송 시각
  final bool isSystemMessage; // 시스템 메시지 여부
  final bool? isDateMessage; // 날짜 표시 위젯 여부

  Message({
    this.isDateMessage = false,
    required this.text,
    required this.isUserMessage,
    required this.time,
    this.isSystemMessage = false, // 기본값은 false로 설정
  });
}
