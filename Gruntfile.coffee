module.exports = (grunt) ->
  require('jit-grunt')(grunt);

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      all:
        options:
          bare: true
          sourceMap: true

        expand: true
        flatten: false
        cwd: 'src/'
        src: ['**/*.coffee']
        dest: 'bin/.int/'
        ext: '.js'

    less:
      all:
        options:
          compress: true
          optimization: true
          sourceMap: true

        expand: true
        flatten: false
        cwd: 'src/'
        src: ['**/*.less']
        dest: 'bin/'
        ext: '.css'

    pug:
      all:
        expand: true
        flatten: false
        cwd: 'src/'
        src: ['**/*.pug']
        dest: 'bin/'
        ext: '.html'

    babel:
      all:
        options:
          plugins: [
            ['transform-react-jsx',
            {
              pragma: 'JSXDom.createElement'
            }]
          ]

        expand: true
        flatten: false
        cwd: 'bin/.int/'
        src: ['**/*.js']
        dest: 'bin/'
        ext: '.js'

    watch:
      less:
        files: ['src/**/*.less']
        tasks: ['less:all']
      coffee:
        files: ['src/**/*.coffee']
        tasks: ['coffee:all', 'babel:all']
      pug:
        files: ['src/**/*.pug']
        tasks: ['pug:all']

  grunt.registerTask('default', ['coffee', 'babel', 'less', 'pug', 'watch'])
