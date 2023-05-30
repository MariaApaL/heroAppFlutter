class CloudStorageException implements Exception {
  const CloudStorageException();
}

class CouldNotCheckFavSuperheroException extends CloudStorageException {}

class CouldNotAddSuperheroException extends CloudStorageException {}

class CouldNotGetAllSuperherosException extends CloudStorageException {}

class CouldNotDeleteSuperheroException extends CloudStorageException {}