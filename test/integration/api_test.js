const chai = require('chai');
const { expect } = chai;

import {default as chaiHttp, request} from "chai-http";

chai.use(chaiHttp);
const app = require('../../app');

describe('GET /api', () => {
    it('/api should be reachable', function (done) {
        // chai.request(app)
        //     .get('/api')
        //     .end((err, res) => {
        //         if (err) return done(err);
        //         expect(res).to.have.status(200);
        //         expect(res).to.be.an('object');
        //         done();
        //     });
    });
});