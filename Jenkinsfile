node () {
  deleteDir()

  stage ('Checkout') {
    checkout scm
  }

  stage ('Create Env') {
      def buildEnv = docker.build 'androidsdk24:1.0'
  }

}
