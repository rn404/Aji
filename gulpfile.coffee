gulp   = require 'gulp'
coffee = require 'gulp-coffee'
sass   = require 'gulp-sass'
gutil  = require 'gulp-util'
plumber = require 'gulp-plumber'
concat = require 'gulp-concat'

gulp.task 'default', ['compile-coffee', 'compile-sass']

gulp.task 'compile-coffee', () ->
  gulp
    .src('assets/coffee/**/*.coffee')
    .pipe(plumber())
    .pipe(coffee({bare: true})).on('error', gutil.log)
    .pipe(gulp.dest('www/js'))

gulp.task 'compile-sass', () ->
  gulp
    .src ['assets/scss/**/*.scss']
    .pipe sass()
    .pipe gulp.dest('www/css')

