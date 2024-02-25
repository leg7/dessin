#pragma once
#include "Variable.h"

class Propriete: public Variable
{
	Forme::Propriete _prop;
	int _indexPoint;

	public:
	Propriete(const std::shared_ptr<Contexte> &c, const std::string &key, Forme::Propriete p, int indexPoint = -1)
		: Variable(c, key), _prop(p), _indexPoint(indexPoint) {}

	virtual std::shared_ptr<Element> eval() const noexcept override {
		return std::dynamic_pointer_cast<Forme>(_c->at(_key))->getPropriete(_prop, _indexPoint)->eval();
	};
};
