#pragma once
#include "Instruction.h"
#include "../elements/Element.h"
#include "../Contexte.h"
#include <memory>
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
	std::string _nom, _nom_special;
	std::shared_ptr<Element> _val;

	public:
	Declaration(const std::shared_ptr<Contexte> &contexte,
			std::shared_ptr<Element> val,
			std::string nom) noexcept:
		Instruction(contexte), _nom(nom), _val(val) {}

	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Carre> &e, const std::string &nom = "") noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Rectangle> &e, const std::string &nom = "") noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Triangle> &e, const std::string &nom = "") noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Cercle> &e, const std::string &nom = "") noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ellipse> &e, const std::string &nom = "") noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Ligne> &e, const std::string &nom = "") noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Chemin> &e, const std::string &nom = "") noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Texte> &e, const std::string &nom = "") noexcept;
	Declaration(const std::shared_ptr<Contexte> &contexte, const std::shared_ptr<Forme> &e, const std::string &nom = "") noexcept;

	virtual void executer() const noexcept override;
};
