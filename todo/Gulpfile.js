var gulp = require('gulp');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');


gulp.task('default', function(){
    gulp.src('todo/index.coffee', {read: false})
    .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']
    }))
    .pipe(rename('app.js'))
    .pipe(gulp.dest('./public/js'))
});


gulp.task('watch', function(){
    gulp.watch('./todo/**/*.*', ['default']);
});