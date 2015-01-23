var gulp = require('gulp');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');
var uglify = require('gulp-uglify');
var filter = require('gulp-filter');
var deploy = require('gulp-gh-pages');


gulp.task('default', ['todo', 'hello_world', 'hello_world2']);


gulp.task('todo', function(){
    return gulp.src('./todo/todo/index.coffee', {read: false})
    .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']}))
    .pipe(rename('app.js'))
    .pipe(gulp.dest('./todo/public/js'));
});


gulp.task('deploy_todo', ['default'], function(){
    jsfilter = filter(['**/*.js'])
    return gulp.src('./todo/public/**/*.*')
    .pipe(jsfilter)
    .pipe(uglify())
    .pipe(jsfilter.restore())
    .pipe(gulp.dest('./dist/todo/public'));
});


gulp.task('hello_world', function(){
    return gulp.src('./hello_world/hello_world/index.coffee', {read: false})
    .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']}))
    .pipe(rename('app.js'))
    .pipe(gulp.dest('./hello_world/public/js'));
});


gulp.task('deploy_hello_world', ['default'], function(){
    jsfilter = filter(['**/*.js'])
    return gulp.src('./hello_world/public/**/*.*')
    .pipe(jsfilter)
    .pipe(uglify())
    .pipe(jsfilter.restore())
    .pipe(gulp.dest('./dist/hello_world/public'));
});


gulp.task('hello_world2', function(){
    return gulp.src('./hello_world2/hello_world2/index.coffee', {read: false})
    .pipe(browserify({
        transform: ['coffeeify'],
        extensions: ['.coffee']}))
    .pipe(rename('app.js'))
    .pipe(gulp.dest('./hello_world2/public/js'));
});


gulp.task('deploy_hello_world2', ['default'], function(){
    jsfilter = filter(['**/*.js'])
    return gulp.src('./hello_world2/public/**/*.*')
    .pipe(jsfilter)
    .pipe(uglify())
    .pipe(jsfilter.restore())
    .pipe(gulp.dest('./dist/hello_world2/public'));
});


gulp.task('copy_main_index', function(){
    return gulp.src("index.html").pipe(gulp.dest('./dist'));
});


gulp.task('deploy',
    [
        'deploy_hello_world',
        'deploy_todo',
        'copy_main_index',
        'deploy_hello_world2'], function (){
    return gulp.src("./dist/**/*")
    .pipe(deploy());
});


gulp.task('watch', function(){
    gulp.watch('./todo/todo/**/*.*', ['todo']);
    gulp.watch('./hello_world/hello_world/**/*.*', ['hello_world']);
    gulp.watch('./hello_world2/hello_world2/**/*.*', ['hello_world2']);
});

