#pragma once
#include <array>
#include <string>

class Element
{
	public:
	static constexpr int enumTypeFormeEnd = 20;
	static constexpr int nombreDeFormes = 8;
	enum class Type
	{
		Carre,
		Cercle,
		Chemin,
		Ellipse,
		Ligne,
		Rectangle,
		Texte,
		Triangle,
		ElementPrimitf = enumTypeFormeEnd,
		Couleur,
		Taille,
	};
	static constexpr const char* nomFormes[nombreDeFormes] = { "carre", "rectangle", "triangle", "cercle", "ellipse", "ligne", "chemin", "texte" };
	static bool isFormeType(Type t) noexcept { return static_cast<int>(t) < enumTypeFormeEnd; }
	virtual double toDouble() const noexcept = 0;
	virtual Type type() const noexcept = 0;
};
