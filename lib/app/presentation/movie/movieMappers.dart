import 'package:state_navigation/domain/model/movie.dart';
import 'movie.dart';

extension MovieDMtoVM on Movie {
  MovieVM toVM() => MovieVM(
        id: this.id,
        url: this.url,
        isFavorite: false,
      );
}

MovieVM toVM(Movie movie) => movie.toVM();
