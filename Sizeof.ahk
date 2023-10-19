;numData := Sizeof("Int,float")
;MsgBox( numData.Size )

Class Sizeof {
	static dataSize := Array()
	static searchTypes := Array()
	__New(x) {
		this.Size := 0
		Sizeof.dataSize := StrSplit( x, "," )
		this.Sizes()
	}
	Sizes() {
		value := 0
		for i, j in Sizeof.dataSize {
			value  += IniRead( "Types.ini", "Sizes", StrUpper(j) )
			this.Size := value
		}
	}
}
