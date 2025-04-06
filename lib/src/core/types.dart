typedef Success<T> = void Function(T context);
typedef Error<T> = void Function(T context);

/// Headers
typedef Headers = Map<String, String>;
const Headers appHeader = {'Content-Type': 'application/json'};
