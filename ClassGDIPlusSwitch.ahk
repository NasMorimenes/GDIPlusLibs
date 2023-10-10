/* GdipSwitch

  Developer's original text:
    O objetivo dessa classe é criar uma espécie de "interruptor" da Biblioteca GDIPlus para uso em script AutoHokey V2.

Text translated by ChatGPT:
    The purpose of this class is to create a kind of "switch" for the GDIPlus Library for use in AutoHotkey V2 scripts.

*/

Class GdipSwitch {

	static hModule      := DllCall( "GetModuleHandle"
                                  , "Str", "gdiplus"
	                                  , "Ptr" )
	static sizePointer  := A_PtrSize = 8 ? 24 : 16
	static Token        := Buffer( GdipSwitch.sizePointer, 0 )
	static sInput       := Buffer( 0, 0 )

	__New() {
		this.statusLib  := GdipSwitch.GetModuleHandle(GdipSwitch.hModule)
			if ( this.statusLib ) {
				GdipSwitch.GdiplusStartupInput()
			}
	}

	static GetModuleHandle( hModule ) {
		if ( !hModule) {
			hModule := DllCall( "LoadLibrary"
					  , "Str", "gdiplus"
					  , "Ptr" )

			GdipSwitch.hModule := hModule
			statusLib := hModule ? 1 : 0
		}
		else {
			GdipSwitch.GetOffGDIPlus()
			statusLib := DllCall( "FreeLibrary"
                          , "Ptr", hModule
                          , "Int" )

			GdipSwitch.hModule := 0
			statusLib := hModule ? 0 : 1

		}
		return statusLib

	}

	static GetOnGDIPlus() {
		statusGDIPlus := DllCall( "gdiplus\GdiplusStartup"
                            , "Ptr"  	, GdipSwitch.Token.Ptr
                            , "Ptr"   , GdipSwitch.sInput.Ptr
                            , "Ptr"   , 0
                            , "Int64" )
    }

	static GetOffGDIPlus() {
		DllCall( "gdiplus\GdiplusShutdown"
           , "Ptr", GdipSwitch.Token.Ptr )
		GdipSwitch.Token := 0

    }

	static GdiplusStartupInput() {        
		GdipSwitch.sInput.Size := GdipSwitch.sizePointer
		NumPut( "Ptr"
          , 1
          , GdipSwitch.sInput )
		GdipSwitch.GetOnGDIPlus()
	}
}
