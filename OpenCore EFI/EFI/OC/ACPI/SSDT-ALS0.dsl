// Fake light sensor.
// credit RehabMan
#ifndef NO_DEFINITIONBLOCK
DefinitionBlock ("", "SSDT", 2, "hack", "ALS0", 0x00000000)
{
#endif
    Device (_SB.ALS0)
    {
        Method (_STA)
        {
            If (_OSI ("Darwin"))
            {
                Return (0x0F)
            }
            Return (0)
        }
        Name (_HID, "ACPI0008")  // _HID: Hardware ID
        Name (_CID, "smc-als")  // _CID: Compatible ID
        Name (_ALI, 0x012C)  // _ALI: Ambient Light Illuminance
        Name (_ALR, Package (0x01)  // _ALR: Ambient Light Response
        {
            Package (0x02)
            {
                0x64, 
                0x012C
            }
        })
    }
#ifndef NO_DEFINITIONBLOCK
}
#endif

