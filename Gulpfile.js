var gulp = require('gulp');
var browserify = require('gulp-browserify');
var rename = require('gulp-rename');
var uglify = require('gulp-uglify');
var filter = require('gulp-filter');
var deploy = require('gulp-gh-pages');


var apps = ['hello_world', 'todo', 'hello_world2'];


// Build
apps.map(function(app){
    gulp.task(app, function(){
        return gulp.src('./' + app + '/' + app + '/index.coffee', {read: false})
        .pipe(browserify({
            transform: ['coffeeify'],
            extensions: ['.coffee']}))
        .pipe(rename('app.js'))
        .pipe(gulp.dest('./' + app + '/public/js'));
    });    
});

// Deploy
apps.map(function(app){
    gulp.task('deploy_' + app, function(){
        jsfilter = filter(['**/*.js'])
        return gulp.src('./' + app + '/public/**/*.*')
        .pipe(jsfilter)
        .pipe(uglify())
        .pipe(jsfilter.restore())
        .pipe(gulp.dest('./dist/' + app + '/public'));
    });
});

// Watch
gulp.task('watch', function(){
    apps.map(function(app){
        gulp.watch('./' + app + '/' + app + '/**/*.*', [app]);
    });
});

gulp.task('default', apps);

gulp.task('copy_main_index', function(){
    return gulp.src("index.html").pipe(gulp.dest('./dist'));
});

gulp.task('deploy_apps', ['default'], function() {
    apps.map(function(app){return 'deploy_' + app});
});


gulp.task('deploy', ['deploy_apps', 'copy_main_index'], function (){
    return gulp.src("./dist/**/*")
    .pipe(deploy());
});

