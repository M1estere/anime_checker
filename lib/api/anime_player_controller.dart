class AnimePlayerController {
  static const _playerStartUrl = 'https://cache.libria.fun';

  String getFullAnimePath(String end) {
    return _playerStartUrl + end;
  }
}
