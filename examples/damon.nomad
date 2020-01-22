job "damon-job" {
    datacenters = ["dc1"]
    type        = "service"
    group "damon-group" {
        count = 1
        task "damon-test-task" {
            artifact {
                ## Replace whith wheverer damon is hosted
                source = "https://github.com/jet/damon/releases/download/v0.1.0/damon_0.1.0_windows_amd64.zip"
            }
            artifact {
                ## Replace with wherever your service artifact is hosted
                source = "https://rareexportslab-windows.s3.amazonaws.com/publish.zip"
            }
            driver = "raw_exec"
            config {
                # Damon is the task entrypoint
                command = "${NOMAD_TASK_DIR}/damon.exe"
                # Your command and services should be in the 'args' section
                args    = ["${NOMAD_TASK_DIR}/publish/RazorMovie.exe"]
            }
            resources {
                cpu    = 1024
                memory = 1024
                network {
                    mbits = 100

                    ## For metrics exposed by Damon
                    port "damon" {}
                    port "razor" {}
                }
            }
            env {
                ## Example of overriding NOMAD_CPU_LIMIT to give it more CPU than allocated
                "DAMON_CPU_LIMIT" = "2048"
            }
            ## For damon's metrics endpoint
            service {
                port = "damon"
                name = "${NOMAD_TASK_NAME}-damon"
            }
        }
    }
}