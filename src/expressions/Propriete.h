#include "Variable.h"

class Propriete: public Variable
{
	Forme::Propriete _prop;
	int _index;
	bool _isX;
	public:
	Propriete(const std::shared_ptr<Contexte> &c, const std::string &key, Forme::Propriete prop, const int index = -1, const bool isX = false): Variable(c, key), _index(index), _prop(prop), _isX(isX) {}
	virtual std::shared_ptr<Element> eval() const noexcept override;
};
