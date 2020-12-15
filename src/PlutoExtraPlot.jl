module PlutoExtraPlot

using RCall, PyCall, PlutoUI

macro Rplot_str(code)
	return quote
		f=tempname() * ".png"
		R"""
		require(ggplot2)
		png($f)
		"""
		@R_str($code)
		R"""
		invisible(print(.Last.value))
		dev.off()
		"""
		res=LocalResource(f)
		rm(f)
		res
	end
end

macro pyplot_str(code)
	return quote
		f=tempname() * ".png"
		py"""
		import matplotlib
		matplotlib.use('Agg')
		import matplotlib.pyplot as plt
		plt.figure()
		"""
		@py_str($code)
		py"""
		plt.savefig($f)
		"""
		res=LocalResource(f)
		rm(f)
		res
	end
end

export @pyplot_str, @Rplot_str

end # module
