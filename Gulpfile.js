var gulp = require('gulp');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');


gulp.task('default', ['todo']);


gulp.task('todo', function(){
    return gulp.src('./todo/todo/index.coffee', {read: false})
    .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']}))
    .pipe(rename('app.js'))
    .pipe(gulp.dest('./todo/public/js'));
});


gulp.task('hello_world', function(){
    return gulp.src('./hello_world/hello_world/index.coffee', {read: false})
    .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']}))
    .pipe(rename('app.js'))
    .pipe(gulp.dest('./hello_world/public/js'));
});


gulp.task('watch', function(){
    gulp.watch('./todo/todo/**/*.*', ['todo']);
    gulp.watch('./hello_world/hello_world/**/*.*', ['hello_world']);
});

