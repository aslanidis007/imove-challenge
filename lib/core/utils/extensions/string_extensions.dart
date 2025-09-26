extension StringExtension on String {
  /// Builds a URL string by converting null or whitespace-only values to empty strings,
  /// merging with any existing parameters, and preserving the original URI if no params provided.
  /// Both null and empty-string values will appear as empty parameters (e.g. `token=`).
  String buildUrl({Map<String, String?>? queryParameters}) {
    final uri = Uri.tryParse(this);
    if (uri == null || !uri.isAbsolute) {
      throw ArgumentError('Invalid URL: $this');
    }

    if (queryParameters == null || queryParameters.isEmpty) {
      // No parameters provided → return original URI
      return uri.toString();
    }

    // Normalize values: trim whitespace, convert nulls to empty strings
    final normalized = queryParameters.entries.map((e) {
      final raw = e.value?.trim() ?? '';
      return MapEntry(e.key, raw);
    });

    // Merge existing parameters with normalized ones (new ones override)
    final mergedParams = {
      ...uri.queryParameters,
      for (final entry in normalized) entry.key: entry.value,
    };

    // Manually build the query string to ensure empty values get '='
    final customQuery = mergedParams.entries
        .map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value)}')
        .join('&');

    // Return the updated URI with all parameters, including empty ones
    return uri.replace(query: customQuery).toString();
  }
}
