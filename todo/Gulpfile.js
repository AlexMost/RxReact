var gulp = require('gulp');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');
var deploy = require('gulp-gh-pages');



gulp.task('default', function(){
    return gulp.src('todo/index.coffee', {read: false})
    .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
    }))
    .pipe(rename('app.js'))
    .pipe(gulp.dest('./public/js'))
});


gulp.task('deploy', ['default'], function(){
	return gulp.src('./public/**/*')
		.pipe(deploy())
});


gulp.task('watch', function(){
    return gulp.watch('./todo/**/*.*', ['default']);
});

