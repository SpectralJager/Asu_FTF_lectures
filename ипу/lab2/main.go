package main

import (
	"fmt"
	"log"
	"time"

	"github.com/google/gousb"
	"github.com/google/gousb/usbid"
)

func main() {
	ctx := gousb.NewContext()
	defer ctx.Close()

	old, new := 0, 0

	for {
		new = 0
		ctx.OpenDevices(func(desc *gousb.DeviceDesc) bool {
			new += 1
			return false
		})
		if old == new {
			time.Sleep(time.Second * 10)
			continue
		} else {
			log.Println()
			ctx.OpenDevices(func(desc *gousb.DeviceDesc) bool {
				fmt.Printf("%d:%d %s:%s %s\n", desc.Bus, desc.Address, desc.Vendor, desc.Product, usbid.Describe(desc))
				// fmt.Printf("Class -> %s\n", desc.Class)
				// fmt.Printf("Device -> %s\n", desc.Device)
				// fmt.Printf("Protocol -> %s\n", desc.Protocol)
				// fmt.Printf("Spec -> %s\n", desc.Spec)
				// fmt.Printf("Speed -> %s\n", desc.Speed)
				// fmt.Printf("MaxControlPacketSize -> %d\n", desc.MaxControlPacketSize)
				// fmt.Printf("Port -> %d\n", desc.Port)
				// for _, cfg := range desc.Configs {
				// 	fmt.Printf("--%s\n", cfg)
				// 	fmt.Printf("  MaxPower -> %d\n", cfg.MaxPower)
				// 	fmt.Printf("  RemoteWakeup -> %v\n", cfg.RemoteWakeup)
				// 	fmt.Printf("  SelfPowered -> %v\n", cfg.SelfPowered)
				// 	fmt.Println("\t--------------------------------------------------")
				// 	for _, ifa := range cfg.Interfaces {
				// 		fmt.Printf("\t%s:\n", ifa)
				// 		for _, als := range ifa.AltSettings {
				// 			fmt.Printf("\t\tClass -> %s\n", als.Class)
				// 			fmt.Printf("\t\tSubClass -> %s\n", als.SubClass)
				// 			fmt.Printf("\t\tProtocol -> %s\n", als.Protocol)
				// 			fmt.Printf("\t\tAlternate -> %d\n", als.Alternate)
				// 			fmt.Printf("\t\tNumber -> %d\n", als.Number)
				// 			for i, ep := range als.Endpoints {
				// 				fmt.Printf("\t\tEndpoint %d:\n", i)
				// 				fmt.Printf("\t\t\tAddress -> %s\n", ep.Address)
				// 				fmt.Printf("\t\t\tDirection -> %s\n", ep.Direction)
				// 				fmt.Printf("\t\t\tIsoSyncType -> %s\n", ep.IsoSyncType)
				// 				fmt.Printf("\t\t\tPollInterval -> %s\n", ep.PollInterval)
				// 				fmt.Printf("\t\t\tTransferType -> %s\n", ep.TransferType)
				// 				fmt.Printf("\t\t\tUsageType -> %s\n", ep.UsageType)
				// 				fmt.Printf("\t\t\tMaxPacketSize -> %d\n", ep.MaxPacketSize)
				// 				fmt.Printf("\t\t\tNumber -> %d\n", ep.Number)
				// 			}
				// 		}
				// 		fmt.Println("\t--------------------------------------------------")
				// }
				// }
				return false
			})
			old = new
			fmt.Println()
		}
	}
}
