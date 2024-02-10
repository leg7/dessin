#pragma once
class Element
{
	public:
	enum class Type
	{
		Boolean,
		Couleur,
		Entier,
		Reel,
		Forme,
	};

	private:
	Type _t;

	public:
	Element(Type t) noexcept: _t(t) {} ;
	Type type() const noexcept { return _t; }
};
