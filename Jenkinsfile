node () {
  deleteDir()

  stage ('Checkout') {
    checkout scm
  }

  stage ('Create Env') {
      sh 'whoami'

      def buildEnv = docker.build 'androidsdk25:1.0'
  }

}
