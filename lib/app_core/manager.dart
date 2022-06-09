abstract class Manager<T> {
  void dispose();
}

enum ManagerState {
  idle,
  loading,
  success,
  error,
  socketError,
  unknownError,
}
