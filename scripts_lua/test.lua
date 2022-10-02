tex = {print = print}

local function titreOptionel(env, titre)
    tex.print("\\let\\orig@" .. env .. "=\\" .. env)
    tex.print("\\def\\" .. env .. "{")
    tex.print("\\@ifnextchar[{\\" .. env .. "@opt}{\\orig@" .. env .. "}}")
    tex.print("\\def\\" .. env .. "@opt[#1]{")
    tex.print("\\orig@" .. env .. "[frametitle={" .. titre .. " : #1}]}")
end

tex.print("\\makeatletter")
titreOptionel("cours", "Cours")
titreOptionel("propriete", "Propriété")
titreOptionel("methode", "Méthode")
titreOptionel("application", "Application")
titreOptionel("vocabulaire", "Vocabulaire")
-- titreOptionel("definition", "Définition")
tex.print("\\makeatother")
