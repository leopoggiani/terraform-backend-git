package cmd

import (
	"log"

	"github.com/spf13/cobra"

	"github.com/plumber-cd/terraform-backend-git/pid"
)

// stopCmd will stop the server started via rootCmd via it's pid file
var stopCmd = &cobra.Command{
	Use:   "stop",
	Short: "Stop the currently running backend",
	Run: func(_ *cobra.Command, _ []string) {
		if err := pid.StopPidFile(); err != nil {
			log.Fatal(err)
		}
	},
}

func init() {
	rootCmd.AddCommand(stopCmd)
}
