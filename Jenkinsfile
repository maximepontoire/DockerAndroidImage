node () {
  deleteDir()

  stage ('Checkout') {
    checkout scm
  }

  stage ('Create Env') {
      sh '/usr/local/bin/docker build -t "androidsdk24:1.0" .'
  }

}
