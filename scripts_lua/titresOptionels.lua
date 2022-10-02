function titreOptionel(env, titre)
    tex.print("\\makeatletter")
    tex.print("\\let\\orig@" .. env .. "=\\" .. env)
    tex.print("\\def\\" .. env .. "{")
    tex.print("\\@ifnextchar[{\\" .. env .. "@opt}{\\orig@" .. env .. "}}")
    tex.print("\\def\\" .. env .. "@opt[#1]{")
    tex.print("\\orig@" .. env .. "[frametitle={" .. titre .. " : #1}]}")
    tex.print("\\makeatother")
end
