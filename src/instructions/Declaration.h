#pragma once
#include "Instruction.h"
#include "../elements/Element.h"
#include "../Contexte.h"
#include <string>
#include "../elements/formes/Carre.h"
#include "../elements/formes/Cercle.h"
#include "../elements/formes/Chemin.h"
#include "../elements/formes/Ellipse.h"
#include "../elements/formes/Ligne.h"
#include "../elements/formes/Rectangle.h"
#include "../elements/formes/Texte.h"
#include "../elements/formes/Triangle.h"

class Declaration: public Instruction
{
	std::string _nom;
	std::shared_ptr<Element> _val;

	public:
	Declaration(const std::shared_ptr<Contexte> &contexte,
			std::string nom,
			std::shared_ptr<Element> val) noexcept:
		Instruction(contexte), _nom(nom), _val(val) {}

	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Carre> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Rectangle> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Triangle> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Cercle> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ellipse> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ligne> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Chemin> &e) noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Texte> &e) noexcept;

	virtual void executer() const noexcept override;
};
