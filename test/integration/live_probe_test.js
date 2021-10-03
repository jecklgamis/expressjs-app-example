const chai = require('chai')
const chaiHttp = require('chai-http');
const {expect} = chai
chai.use(chaiHttp)
const app = require('../../app');

describe('GET /probe/live', () => {
    it('/probe/live should be reachable', function (done) {
        chai.request(app)
            .get('/probe/live')
            .end((err, res) => {
                if (err) done(err)
                expect(res).to.have.status(200)
                expect(res).to.be.an('object')
                done();
            });
    });
});