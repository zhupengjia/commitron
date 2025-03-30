package main

import (
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

// Flags that are used across commands
var configPath string

// rootCmd represents the base command when called without any subcommands
var rootCmd = &cobra.Command{
	Use:   "commitron",
	Short: "AI-powered commit message generator",
	Long:  `Commitron is a CLI tool that generates AI-powered commit messages based on your staged changes in a git repository.`,
	// This is the default command when none is provided
	Run: func(cmd *cobra.Command, args []string) {
		// Run the generate command when no command is specified
		if err := generateCmd.RunE(cmd, args); err != nil {
			fmt.Fprintf(os.Stderr, "Error: %v\n", err)
			os.Exit(1)
		}
	},
}

func init() {
	// Global flags available to all commands
	rootCmd.PersistentFlags().StringVarP(&configPath, "config", "c", "", "Path to the configuration file (default: ~/.commitronrc)")

	// Add all commands
	rootCmd.AddCommand(generateCmd)
	rootCmd.AddCommand(initCmd)
	rootCmd.AddCommand(versionCmd)
}

func main() {
	// Execute the root command
	if err := rootCmd.Execute(); err != nil {
		os.Exit(1)
	}
}
