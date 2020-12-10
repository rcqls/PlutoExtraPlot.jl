module PlutoExtraPlot

using RCall, PyCall, PlutoUI

macro Rplot_str(code)
	return quote
		R"""
		require(ggplot2)
		png("rplot.png")
		"""
		@R_str($code)
		R"""
		invisible(print(.Last.value))
		dev.off()
		"""
		res=LocalResource("./rplot.png")
		rm("./rplot.png")
		res
	end
end

macro pyplot_str(code)
	return quote
		py"""
		import matplotlib.pyplot as plt
		plt.figure()
		"""
		@py_str($code)
		py"""
		plt.savefig('pyplot.png')
		"""
		res=LocalResource("./pyplot.png")
		rm("./pyplot.png")
		res
	end
end

export @pyplot_str, @Rplot_str

end # module
