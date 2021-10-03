const chai = require('chai')
const chaiHttp = require('chai-http');
const {expect} = chai
chai.use(chaiHttp)
const app = require('../../app');


describe('GET /', () => {
    it('/ should be reachable', function (done) {
        chai.request(app)
            .get('/')
            .end((err, res) => {
                if (err) done(err)
                expect(res).to.have.status(200)
                expect(res).to.be.an('object')
                done();
            });
    });
});