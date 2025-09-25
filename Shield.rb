#encoding:utf-8

module Irrgarten

	class Shield
		
		
		#constructor
		def initialize (protection, uses)
			@protection = protection #float
			@uses = uses #int
		end
		
		#protect
		def protect ()
			salida = 0.0
			if @uses > 0 then
				@uses -= 1
				salida = @protection
			end
			salida #se puede poner return pero es opcional, automáticamente se devuelve la última línea
		end
	
		#toString
		def to_s ()
			"S[#{@protection},#{@uses}]"
		end
	end
end
